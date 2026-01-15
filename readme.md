# Dashboard de Cargas - Web API (.NET 8)

Esta é uma Web API robusta desenvolvida para o exercício de gestão de guias de transporte. A aplicação utiliza o padrão de **Minimal APIs** do .NET 8 e foca-se em performance e organização de código através do uso de **Dapper** e **Stored Procedures**.

## Funcionalidades Principais

* **Versionamento de API:** Endpoint versionado via URL (`/api/v1/orders`).
* **Acesso a Dados:** Utilização exclusiva de **Dapper** para execução de **Stored Procedures** com passagem de parâmetros (`StartDate`, `EndDate`).
* **Fallback:** Mecanismo automático que devolve dados simulados (mock) caso a ligação à base de dados SQL Server falhe.
* **Logging:** Registo de operações e erros em consola e ficheiro utilizando **Serilog**.
* **Documentação:** Swagger ativo em ambiente de desenvolvimento para teste imediato dos endpoints.

## Tecnologias Utilizadas

* **.NET 8** (Minimal APIs)
* **Dapper** (Micro-ORM)
* **Microsoft.Data.SqlClient**
* **Asp.Versioning.Http** (Versionamento)
* **Serilog.AspNetCore** (Logging)
* **Swagger/OpenAPI**

## Estrutura do Projeto

* `/Models`: Contém o record `TransportOrder` que define a estrutura da carga.
* `/Repositories`: Implementação do padrão Repository para abstração do Dapper e da lógica de dados.
* `/Scripts`: Contém o ficheiro `CreateStoredProcedure.sql` para configuração do SQL Server.
* `/logs`: Localização dos ficheiros de log gerados automaticamente.

