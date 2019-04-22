# 使い方
```
bundle install vendor/bundle
bundle exec ruby qr.rb input/sample.csv qr
bundle exec ruby qr.rb input/sample.csv code128
bundle exec ruby qr.rb input/sample.csv codabar
```

# 入力ファイルのフォーマット
下記で一行につき1ファイルがoutputディレクトリに生成される
```
1234567890
2345678790
...
```
