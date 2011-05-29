<%@ Application Language="C#" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e) 
    {
        // Code that runs on application startup

    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e) 
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e) 
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }

    protected void Application_BeginRequest(object sender, EventArgs e)
    {
        // Simulate internet latency on local browsing
        if (Request.IsLocal)
            System.Threading.Thread.Sleep(50);
        
        var request = Request;
        var url = request.Url;
        var applicationPath = request.ApplicationPath;
        
        string fullurl = url.ToString();
        string baseUrl = url.Scheme + "://" + url.Authority + applicationPath.TrimEnd('/') +'/';

        string currentRelativePath = request.AppRelativeCurrentExecutionFilePath;
                
        if (request.HttpMethod == "GET")
        {
            if (currentRelativePath.EndsWith(".aspx"))
            {
                // get the folder path from relative path. Eg ~/page.aspx returns empty. ~/folder/page.aspx returns folder/                    
                var folderPath = currentRelativePath.Substring(2, currentRelativePath.LastIndexOf('/') - 1);
                    
                Response.Filter = new Dropthings.Web.Util.StaticContentFilter(
                        Response,
                        relativePath => 
                            {                                
                                if (Context.Cache[relativePath] == null)
                                {
                                    var physicalPath = Server.MapPath(relativePath);
                                    var version = "?v=" + 
                                        new System.IO.FileInfo(physicalPath).LastWriteTime
                                        .ToString("yyyyMMddhhmmss");
                                    Context.Cache.Add(relativePath, version, null,
                                        DateTime.Now.AddMinutes(1), TimeSpan.Zero,
                                        CacheItemPriority.Normal, null);                                    
                                    return version;
                                }
                                else
                                {
                                    return Context.Cache[relativePath] as string;
                                }
                            },
                        "http://images.mydomain.com/",
                        "http://scripts.mydomain.com/",
                        "http://styles.mydomain.com/", 
                        baseUrl,
                        applicationPath,
                        folderPath);
                }
            }
            
    }
</script>
