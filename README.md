# Ukázka vývoje webové aplikace v Ruby on Rails

## Založení nové aplikace
```sh
# vytvoří adresář 'ukazka' a v něm kostru aplikace
# a nainstaluje potřebné gemy pomocí bundleru
rails new ukazka
```

## Vyzkoušení, že aplikace funguje
```sh
cd ukazka

# spustíme aplikační server
bundle exec rails server
```

Prakticky všechny příkazy v shellu musíme prefixovat pomocí `bundle exec` a to proto, abychom spustitelné příkazy nainstalovaných gemů spouštěli ve správném kontextu knihoven. Více o bundleru se dozvíte na https://bundler.io/ .

Náše aplikace teď běží na http://localhost:3000 , což je výchozí nastavení.
Více k nastavení serveru se dozvíte z `bundle exec rails server --help`

`bundle exec rails` bez dalšího parametru vypíše seznam příkazů, které zná:
```sh
bundle exec rails
The most common rails commands are:
 generate     Generate new code (short-cut alias: "g")
 console      Start the Rails console (short-cut alias: "c")
 server       Start the Rails server (short-cut alias: "s")
 test         Run tests except system tests (short-cut alias: "t")
 test:system  Run system tests
 dbconsole    Start a console for the database specified in config/database.yml
              (short-cut alias: "db")

 new          Create a new Rails application. "rails new my_app" creates a
              new application called MyApp in "./my_app"
...

```
U nejpoužívanějších příkazů existují krátké aliasy, takže místo `bundle exec rails console` stačí `bundle exec rails c` pro spuštění Rails konzole.
Pro ušetření několika úhozů osobně používám `alias be='bundle exec'` v `~/.bashrc` nebo podobný. Pak obdobný příkaz vypadá `be rails c`.

## Vytvoření prvního controlleru, který zobrazuje statické stránky
```sh
bundle exec rails generate controller pages main about
```
Tento ^ příkaz vygeneruje soubor `app/controllers/pages_controller.rb` s minimálním kódem pro controller jménem PagesController se dvěma akcemi (main a about) a stejně tak soubory pro šablony ke každé akci do adresáře `app/views/pages/`. Navíc do souboru `config/routes.rb` zapíše nová pravidla pro routování požadavků ke controlleru, a to `get 'pages/main'` a `get 'pages/about'`.

Příkaz `bundle exec generate controller` bez dalších parametrů vypíše obsáhlou nápovědu k tomu, jak ho použít.
Obdobně můžete zjistit nápovědu ke všem generátorům, které máte v aplikaci (mnohé gemy vám přidají nové generátory nebo rozšíří či modifikují stávající).
Jejich seznam dostanete příkazem `bundle exec rails generate`.

Seznam všech routovacích pravidel dostanete z příkazu `bundle exec rails routes`. (Platí pro Ruby on Rails 5.0 a novější. Se staršími verzemi musíte použít `bundle exec rake routes`.)
O routování se dozvíte více na https://guides.rubyonrails.org/routing.html .

Nyní by mělo být možné navštívit http://localhost:3000/pages/main a http://localhost:3000/pages/about .

## Změna obsahu stránek / šablony

V základním nastavení Ruby on Rails používají ERB (Embedded Ruby) jako svůj šablonový jazyk.
Obecně stačí vědět, že Ruby on Rails "vezme" soubory s příponou `.erb` (jako třeba vygenerované šablony `app/views/pages/main.html.erb` a `app/views/pages/about.html.erb`) a "prožene" je přes ERB, které vyhodnotí Ruby kód v šabloně a vrátí šablonu. Pravidla jsou:

```erb
<% Ruby code -- inline with output %>
<%= Ruby expression -- replace with result %>
<%# comment -- ignored -- useful in testing %>
% a line of Ruby code -- treated as <% line %> (optional -- see ERB.new)
%% replaced with % if first thing on a line and % processing is used
<%% or %%> -- replace with <% or %> respectively
```
a jiný text nechá beze změny.

## Scaffold, modely, migrace

```sh
bundle exec rails generate scaffold channel name:string
bundle exec rails generate scaffold message text:text
```

Tyto dva příkazy využívají generátor jménem scaffold (lešení), který vygeneruje kompletní minimální kód pro model, controller se sadou akcí (index, show, new, create, edit, update, delete) a příslušnými šablonami i s formuláři, stejně jako i kompletní routování pro dané akce držíce se REST principů. Spolu s modelem vygeneruje i soubor migrace, s controllerem a views i soubory css stylů a js scriptů.

Model je v adresáři `app/models/` a po vygenerování to je jen prázdná třída dědící z ApplicationRecord:
```ruby
class Channel < ApplicationRecord
end
```
