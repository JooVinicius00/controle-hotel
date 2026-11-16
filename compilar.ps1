param([switch]$Verificar)
$ErrorActionPreference = 'Stop'
$raiz = $PSScriptRoot
$binJava = $null
if ($env:JAVA_HOME -and (Test-Path -LiteralPath (Join-Path $env:JAVA_HOME 'bin\javac.exe'))) {
    $binJava = Join-Path $env:JAVA_HOME 'bin'
}
if (-not $binJava) {
    $comando = Get-Command javac.exe -ErrorAction SilentlyContinue
    if ($comando) { $binJava = Split-Path -Parent $comando.Source }
}
if (-not $binJava) {
    $plugins = Join-Path $env:USERPROFILE '.p2\pool\plugins'
    if (Test-Path -LiteralPath $plugins) {
        foreach ($pasta in (Get-ChildItem -LiteralPath $plugins -Directory -Filter 'org.eclipse.justj.openjdk*' | Sort-Object Name -Descending)) {
            $candidato = Join-Path $pasta.FullName 'jre\bin'
            if (Test-Path -LiteralPath (Join-Path $candidato 'javac.exe')) { $binJava = $candidato; break }
        }
    }
}
if (-not $binJava) { throw 'JDK 17 ou superior nao encontrado. Configure JAVA_HOME ou adicione javac ao PATH.' }
$javac = Join-Path $binJava 'javac.exe'
$jar = Join-Path $binJava 'jar.exe'
$java = Join-Path $binJava 'java.exe'
$classes = Join-Path $raiz 'build\classes'
$testes = Join-Path $raiz 'build\test-classes'
$dist = Join-Path $raiz 'dist'
New-Item -ItemType Directory -Path $classes,$dist -Force | Out-Null
$fontes = @(Get-ChildItem -LiteralPath (Join-Path $raiz 'src\main\java') -Recurse -File -Filter '*.java')
$lista = Join-Path $raiz 'build\fontes.args'
$linhas = @($fontes | ForEach-Object { '"' + $_.FullName.Replace('\','/') + '"' })
[System.IO.File]::WriteAllLines($lista, [string[]]$linhas, (New-Object System.Text.UTF8Encoding($false)))
& $javac -source 8 -target 8 -Xlint:-options -encoding UTF-8 -proc:none -d $classes "@$lista"
if ($LASTEXITCODE -ne 0) { throw 'Falha na compilacao. Use JDK 17 ou superior e consulte a mensagem acima.' }
$recursos = Join-Path $raiz 'src\main\resources'
if (Test-Path -LiteralPath $recursos) {
    Get-ChildItem -LiteralPath $recursos | Copy-Item -Destination $classes -Recurse -Force
}
$arquivoJar = Join-Path $dist 'controle-hotel-java.jar'
& $jar --create --file $arquivoJar --main-class darwin.Hotel -C $classes .
if ($LASTEXITCODE -ne 0) { throw 'Falha ao gerar o JAR.' }
Write-Output 'Compilado: controle-hotel-java'
if ($Verificar) {
    New-Item -ItemType Directory -Path $testes -Force | Out-Null
    $fontesTeste = @(Get-ChildItem -LiteralPath (Join-Path $raiz 'src\test\java') -Recurse -File -Filter '*.java')
    $listaTeste = Join-Path $raiz 'build\testes.args'
    $linhasTeste = @(@($fontes) + @($fontesTeste) | ForEach-Object { '"' + $_.FullName.Replace('\','/') + '"' })
    [System.IO.File]::WriteAllLines($listaTeste, [string[]]$linhasTeste, (New-Object System.Text.UTF8Encoding($false)))
    & $javac -source 8 -target 8 -Xlint:-options -encoding UTF-8 -proc:none -d $testes "@$listaTeste"
    if ($LASTEXITCODE -ne 0) { throw 'Falha ao compilar as verificacoes.' }
    if (Test-Path -LiteralPath $recursos) { Get-ChildItem -LiteralPath $recursos | Copy-Item -Destination $testes -Recurse -Force }
    & $java "-Djava.awt.headless=true" -cp $testes testes.Testes
    if ($LASTEXITCODE -ne 0) { throw 'Uma verificacao falhou.' }
}
