# jleaners

以下を実行すると`data/difficulty.csv`というファイルが作成される
```
./calc_difficulty.sh list_person_all_extended_utf8.csv
```

web appはそれを利用してJLPTのレベルに応じた読みやすい順に並べる

```
bundle exec ruby app.rb -o 0.0.0.0
```
