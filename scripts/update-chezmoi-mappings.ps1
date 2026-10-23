# 新增或删除原始配置文件后，重新生成 chezmoi 部署映射。
$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
$utf8 = New-Object System.Text.UTF8Encoding($false)
$expected = @{}
function Add-Mapping($source, $target) {
    $file = [System.IO.Path]::GetFullPath((Join-Path $repo ($target + '.tmpl')))
    $expected[$file] = $true
    [System.IO.Directory]::CreateDirectory((Split-Path -Parent $file)) | Out-Null
    # 模板只引用原始配置，避免维护多份内容。
    $body = '{{ include (joinPath .chezmoi.sourceDir "' + $source + '") }}'
    [System.IO.File]::WriteAllText($file, $body, $utf8)
}
# 扫描配置目录，跳过说明文档、旧备份和本机运行数据。
foreach ($dir in @('nvim-config', 'vim-config')) {
    $base = Join-Path $repo $dir
    Get-ChildItem -LiteralPath $base -File -Recurse -Force | ForEach-Object {
        $relative = $_.FullName.Substring($base.Length + 1).Replace('\', '/')
        if ($relative -match '\.md$|LICENSE$|\.old$|^\.vimrc$') { return }
        if ($relative -match '^(bundles|plugged|cache|tmp)/') { return }
        if ($dir -eq 'nvim-config') {
            # 分别生成 Unix 和 Windows 默认配置路径的映射。
            Add-Mapping "$dir/$relative" "dot_config/nvim/$relative"
            Add-Mapping "$dir/$relative" "AppData/Local/nvim/$relative"
        } else {
            Add-Mapping "$dir/$relative" "dot_vim/$relative"
        }
    }
}
# 生成入口文件映射，由 .chezmoiignore 按平台选择部署。
Add-Mapping 'zsh-config/.zshrc' 'dot_zshrc'
Add-Mapping 'vim-config/.vimrc' 'dot_vimrc'
Add-Mapping 'vim-config/.vimrc' '_vimrc'
# 清理已不再对应原始配置文件的映射模板。
foreach ($root in @('dot_config/nvim', 'AppData/Local/nvim', 'dot_vim')) {
    Get-ChildItem -LiteralPath (Join-Path $repo $root) -File -Recurse -Filter '*.tmpl' | ForEach-Object {
        if (-not $expected.ContainsKey($_.FullName)) { Remove-Item -LiteralPath $_.FullName }
    }
}
