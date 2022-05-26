# docker_python3_selenium_firefox
以下の記事を基に作成しました python3 firefox selenium 環境です。

[SeleniumでヘッドレスFirefoxを利用する](https://selenium-world.net/selenium-tips/3746/)
[FirefoxとSeleniumを使用しPythonでブラウザの自動化を実行する](https://laboratory.kazuuu.net/run-browser-automation-in-python-using-firefox-and-selenium/)

もともとgoogle-chromeで作成を考えおりましたが、WSL2でのDockerではコンテナ内のブラウザクラッシュ多発にて、断念しました。
MacやLinuxベースのホストだと正常動作が期待できるのかもしれません。

DISPLAY環境変数がセット済ですので、ホストOS側にX Windowを用意
頂ければ、コンテナ内のgoogle-chromeを表示可能です。

export DISPLAY=host.docker.internal:0.0

# docker_python3_selenium_firefox
