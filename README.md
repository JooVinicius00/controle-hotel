# Controle de ocupação de hotel

Controle de ocupação de cinco andares com cinco quartos por andar, com menu em JOptionPane.

## O que este projeto demonstra

- Matriz substitui as 25 variáveis de quartos.
- Listagem mostra andar e quarto corretos.
- Validação de limites, opções e cancelamento.

## Executar no Windows

1. Para usar o JAR já gerado nesta cópia local, tenha Java 8 ou superior e abra `executar.bat`.
2. Para recompilar, use JDK 17 ou superior e abra `compilar.bat`. O script também procura o JDK incluído no Eclipse.
3. Para compilar e rodar as verificações, abra `verificar.bat`.

O JAR fica em `dist/controle-hotel-java.jar`. Os scripts não instalam programas nem alteram o Java do sistema.

## Abrir na IDE ou usar Maven

Abra a pasta pelo `pom.xml` no Eclipse, IntelliJ IDEA ou outra IDE com suporte a Maven.
Com JDK 17+ e Maven instalados:

```sh
mvn package
mvn exec:java -Dexec.mainClass=darwin.Hotel
```

O Maven produz o JAR em `target/`; os scripts do Windows produzem em `dist/`.
O comando Maven não roda os testes de contrato automaticamente. Use `verificar.bat`, ou:

```sh
mvn test-compile exec:java -Dexec.mainClass=testes.Testes -Dexec.classpathScope=test
```

## Estrutura

- `src/main/java`: código-fonte.
- `src/main/resources`: recursos visuais, quando houver.
- `src/test/java`: verificações sem dependências de teste externas.
- `ORIGEM.md`: fontes usadas e histórico das correções.
- `.gitignore`: evita versionar arquivos gerados e configurações locais.

## Publicar no GitHub

Use esta pasta como um repositório independente. Faça o primeiro commit com os fontes, README e configuração de build.
`build/`, `dist/` e `target/` são gerados localmente e estão no `.gitignore`.
O arquivo `db.properties`, quando existir, deve continuar apenas no seu computador.
Não foi escolhida uma licença nesta organização dos materiais; confirme a autoria e os créditos ao publicar.


## Dados

A ocupação fica na memória e é reiniciada ao fechar o aplicativo.

