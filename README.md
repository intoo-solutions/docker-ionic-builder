# docker-ionic-builder

Image basée sur beevelop/ionic avec un ChromeHeadless, afin de passer les tests (ionic).

L'installation de chrome est inspirée de SeleniumHQ/docker-selenium : https://github.com/SeleniumHQ/docker-selenium

Si l'erreur suivante survient 

```
Cannot start ChromeHeadless [] Running as root without --no-sandbox is not supported. See https://crbug.com/638180.

```

Alors lancer ChromeHeadless avec le flag `--no-sandbox` : https://github.com/karma-runner/karma-chrome-launcher/issues/158




