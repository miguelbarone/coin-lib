# CoinLib

CoinLib é um aplicativo feito usando como base as API’s do coinapi.io, focado em ter um UI/UX simples e objetiva, listando as principais informações e detalhes sobre os Assets do mercado.

## Tecnologia
O projeto é estruturado na arquitetura VIP com Coordinator, utilizando de uma Factory individual por tela para fazer as injeções das interfaces do ciclo VIP.
Os layout seguem e respeitam as guidelines da Apple, além de suportar dark e light mode do dispositivo. As telas são feita com View Code, utilizando o NSLayoutConstraints nativo para estruturação dos componentes.

## Melhorias futuras
- Passar o UIKit para SwiftUI e manter o aplicativo atualizado com as novas tecnologias da Apple;
- Criar tratamento de erros por status code e exibir feedbacks mais customizados para o usuário;
- Modularizar as camadas de UI e Network, separando melhor as responsabilidades dentro do projeto; 
- Criar um componente para o gráfico da tela de Detalhes e torná-lo dinâmico aos dados presentes;