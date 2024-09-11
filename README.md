# CoinLib

CoinLib é um aplicativo feito usando como base as API’s do coinapi.io, focado em ter um UI/UX simples e objetiva, listando as principais informações e detalhes sobre os Assets do mercado.

## Tecnologia
O projeto é estruturado na arquitetura VIP com Coordinator, utilizando de uma Factory individual por tela para fazer as injeções das interfaces do ciclo VIP.
As telas são desenvolvidas em View Code, com auxílio do SnapKit para construção das constraints e melhor legibilidade da estruturação dos componentes visuais.

## Dependências
O CoinLib usa o SPM (Swift Package Manager) como gerenciador de dependências do projeto, as seguintes bibliotecas estão presentes:
- SnapKit;
- SnapshotTesting;
