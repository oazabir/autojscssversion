A super fast HTTP filter that looks at the generated output of aspx files and appends the last modified date of the js and css files on the URL as query string. Thus it allows static files to be cached on browser and to be updated whenever the files are modified on the server.
It means, this:
```
<script src="scripts/jquery-1.4.1.min.js" ></script>
<script src="scripts/TestScript.js" ></script>
<link href="Styles/Stylesheet.css" />
```
gets converted to this:
```
<script src="scripts/jquery-1.4.1.min.js?v=20100319021342" ></script>
<script src="scripts/TestScript.js?v=20110522074353" ></script>
<link href="Styles/Stylesheet.css?v=20110522074829" />
```
Here the files last modified datetime is appended to the URL automatically. Whenever you change the file content, it gets updated automatically and browsers get newer version immediately.

Here's a detail article on this:
http://www.codeproject.com/KB/aspnet/autojscssversion.aspx

It is super fast. See the CPU consumption on a server that does not have the filter installed:
![http://www.codeproject.com/KB/aspnet/autojscssversion/image004.png](http://www.codeproject.com/KB/aspnet/autojscssversion/image004.png)

And CPU when it has the filter installed:
![http://www.codeproject.com/KB/aspnet/autojscssversion/image005.png](http://www.codeproject.com/KB/aspnet/autojscssversion/image005.png)

There's almost no difference!

[![](http://omaralzabir.com/plea.png)](http://omaralzabir.com/charity)