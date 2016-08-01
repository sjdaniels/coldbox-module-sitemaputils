component {

	this.title 				= "Sitemap Utilities Module";
	this.author				= "Sean Daniels";
	this.webURL				= "http://www.braunsmedia.com";
	this.description		= "Module for Creating Sitemaps and Sitemap Indexes";
	this.version 			= "1.0";

	// The module entry point using SES
	this.entryPoint     = "sitemaputils";
	function configure(){
	}

	function onLoad() {
		var settings = controller.getConfigSettings();
		parseParentSettings();

		var distPath = expandpath(settings.sitemaputils.dist);
		if (!directoryExists(distPath))
			directoryCreate(distPath);
	}

	private function parseParentSettings(){
		var oConfig 		= controller.getSetting( "ColdBoxConfig" );
		var configStruct 	= controller.getConfigSettings();
		var sitemaputils 	= oConfig.getPropertyMixin( "sitemaputils", "variables", structnew() );

		//defaults
		configStruct.sitemaputils = {
			// The path to sitemap distribution, relative to parent app root
			 "dist" : "/assets/dist/sitemaps"
			// Base HREF for URLs in sitemaps
			,"basehref" : "http#cgi.server_port_secure?'s':''#://#cgi.server_name#"
			// Max number of URLs to include per sitemap
			,"limit" : 50000
		};

		// incorporate settings
		structAppend( configStruct.sitemaputils, sitemaputils, true );
	}
}