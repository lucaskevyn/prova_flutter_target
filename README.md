# Prova Target de Flutter

Projeto Flutter que atende requisitos propostos pela prova da Target.

## Login

Tela de autenticação onde o usuário é obrigado a digitar seu login e senha.

<img src="https://github.com/lucaskevyn/prova_flutter_target/assets/13561290/08232a7d-0926-40b8-835f-8af893055754)https://github.com/lucaskevyn/prova_flutter_target/assets/13561290/08232a7d-0926-40b8-835f-8af893055754" width="200">

<img src="https://github.com/lucaskevyn/prova_flutter_target/assets/13561290/b27a6082-95d5-423b-80fa-ca7aad4c5567" width="200">

### Requisitos completados

- Verificar e alertar se ambos os campos de Login e senha estão preenchidos. 
  - O campo senha não pode ter menos que dois caracteres. 
  - O campo senha não pode ter caracteres especiais, sendo apenas possível informar 'a' até 'Z' e '0' até '9'. 
- Ambos os campos não podem ultrapassar 20 caracteres. 
- Ambos os campos não podem terminar com o caractere de espaço no final. 
- Se ambas as informações estiverem preenchidas deve ir para a próxima tela. 
- Ao tocar no label "Política de privacidade" uma página web direcionada para o google.com.br deve ser aberta. 
- Mock Api para validação da autenticação

## Captura de informações

Tela que salva informações digitadas pelo usuário em um card, listando essas informações e dando a opção de editar e excluir. As informações não podem ser perdidas ao fechar o app.

<img src="https://github.com/lucaskevyn/prova_flutter_target/assets/13561290/1a4b3e68-937c-442f-80a6-20e062138919" width="200">
<img src="https://github.com/lucaskevyn/prova_flutter_target/assets/13561290/260b24bb-385b-42f3-9147-0f60b27b0b99" width="200">
<img src="https://github.com/lucaskevyn/prova_flutter_target/assets/13561290/d66303ae-a06c-4869-a427-92b12ef5ae9b" width="200">
<img src="https://github.com/lucaskevyn/prova_flutter_target/assets/13561290/b15bb21a-d794-4336-9725-13dcf87571f8" width="200">

### Requisitos completados

- O foco da digitação deve estar o tempo todo no campo de "Digite seu texto" e não pode 
ser perdido ao interagir com a tela. 
- Ao acionar o "enter" o campo tem que verificar se a informação foi preenchida. 
- O Card principal deve receber a informação digitada do campo. 
- As informações precisam ser salvas e lidas uƟlizando a biblioteca shared_ preferences (https://pub.dev/packages/shared_preferences)
- O Icone de excluir deve abrir um pop-up confirmando a ação. 
- Obrigatório a utilização do plugin MOBX para a construção da tela. 
