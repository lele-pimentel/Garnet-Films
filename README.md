# Garnet Films 🎬 - Sistema de Gerenciamento de Catálogo

Um Projeto prático de Banco de Dados desenvolvido como requisito avaliativo para a disciplina de **Segurança de Banco de Dados** na **Fatec Antonio Russo São Caetano do Sul**. O projeto foi construído em colaboração por **Leticia Silva Pimentel** e **Davi Augusto Freitas da Silva**.

O objetivo foi projetar e implementar o ecossistema de dados para a **Garnet Films**, um sistema que simula o gerenciamento de um catálogo de streaming de filmes, integrando desde a criação das tabelas até a automação de auditoria e regras de negócio via banco de dados.

---

## 📌 Funcionalidades e Requisitos Atendidos

- [x] **Modelagem de Dados & Relacionamentos:** Criação de tabelas base (`genero`, `diretor`, `atores`, `filme` e `log_filmes`) com chaves estrangeiras estruturadas.
- [x] **Triggers de Integridade & Auditoria:** Automatização de processos vitais de segurança diretamente no SGBD.
- [x] **Views:** Criação da view `catalogo` para simplificar consultas e alimentar a interface do usuário.
- [x] **Consultas SQL:** Implementação de buscas simples (filtros com `WHERE`) e complexas (múltiplos `INNER JOIN`).
- [x] **Alinhamento com Interface:** Design de protótipos de tela (Dashboard Administrativo e Catálogo do Cliente) que consomem a estrutura de dados.

---

Durante o desenvolvimento deste projeto, assumi o desafio de projetar e validar as **Triggers (Gatilhos)** do sistema. Esse processo transformou minha percepção sobre o papel do banco de dados na segurança e consistência da aplicação:

1. **Auditoria Automatizada:** Desenvolvi os gatilhos `trg_after_insert_filme`, `trg_after_update_filme` e `trg_after_delete_filme`. Eles alimentam a tabela `log_filmes` de forma independente da aplicação, registrando o estado anterior e posterior de qualquer alteração, o que é um pilar crucial na segurança da informação e rastreabilidade de dados.
2. **Integridade em Cascata:** Implementei mecanismos de `UPDATE` e `DELETE` em cascata (como o `trg_cascade_delete_genero`), garantindo que alterações ou exclusões em tabelas pai (ex: apagar um gênero) limpem automaticamente os registros filhos. Isso evita dados órfãos e furos de integridade referencial.

## Estrutura Física das Tabelas (SQL)

Abaixo está a representação da criação e do mapeamento das tabelas geradas no banco de dados através dos scripts SQL:

<img width="801" height="361" alt="p" src="https://github.com/user-attachments/assets/c57ec59d-12c9-4756-9023-5cf27a6b1118" />

---

## Visualização do Catálogo Completo (Interface)

Alinhado ao banco de dados, o catálogo final consome diretamente a **VIEW `catalogo`** para exibir os filmes de forma dinâmica para o cliente final:
<img width="230" height="258" alt="image" src="https://github.com/user-attachments/assets/6cd64bde-0a93-4823-8dc2-b0352bb25540" />
