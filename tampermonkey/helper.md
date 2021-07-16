
## Inject jQuery in Chrome
```
var script = document.createElement('script');script.src = "https://code.jquery.com/jquery-3.4.1.min.js";document.getElementsByTagName('head')[0].appendChild(script);
```

## Common Issues
* chrome sometimes couldn't focuse on an input after redirects. It is actually caused by chrome plugin `surfingkeys`. Just need to disable the plugin for the specific url endpoints in surfingkeys settings
