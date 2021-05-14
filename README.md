# <div align="center">Stock System 📦</div>

##### <div align="center">An inventory system generated from CSV files.</div>

![img](https://i.imgur.com/JrUiCwB.png)

## Project notes 📋

1. Read a .CSV file with migrations and values, and generate a data in system
2. "movimentacao_de_estoque.csv" is a template file and you can rely on it.
3. This system show all errors ocurred in migrations

## Prerequisites ⚙️

1. Ruby 2.5 or higher - *I advise you to use the [RVM](https://rvm.io/)*
2. Bundler - ``` gem install bundler ```
3. Rails - ``` gem install rails ```
4. Yarn - ``` brew install yarn ``` or [Install yarn](https://yarnpkg.com/en/docs/install)
5. Git - ``` brew install git``` or ``` install git ```
6. PostgreSQL - [Download PSQL](https://www.postgresql.org/download/)


## Installation Steps 📌


##### 1. Clone the repository

```$ git clone https://github.com/phbomfim/stock-system.git  ```

##### 2. Change the working directory

```$ cd stock-system ```

##### 3. Install dependencies

```$ bundle install ```

##### 4. Migrate a database

```$ rails db:migrate ```

##### 5. Run the app

```$ rails s ```

## Instructions

1. In the homepage click on "Importar CSV" button. ***Selecet a .csv file named movimentacao_de_estoque.csv !***
2. Next, go to "Movimentações" link and run "Gerar novas movimentações"
3. Now, you have a stock logs and values in your view and database!

## Contribuition 📈

- This repositorie is public and if you wanna help me open a [Pull Request](https://github.com/phbomfim/stock-system/pulls/)
- If you find a error help me and open a [Issue](https://github.com/phbomfim/stock-system/issues/)
