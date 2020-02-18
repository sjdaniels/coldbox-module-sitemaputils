component {

	this.title 				= "Sitemap Utilities Module";
	this.author				= "Sean Daniels";
	this.webURL				= "http://www.braunsmedia.com";
	this.description		= "Module for Creating Sitemaps and Sitemap Indexes";
	this.version 			= "2.0";

	// The module entry point using SES
	this.entryPoint     	= "sitemaputils";
	this.modelNamespace    	= "sitemaputils";
	this.cfmapping    		= "sitemaputils";
	
	function configure(){
		settings = {
			// The path to sitemap distribution, relative to parent app root
			 "dist" : "assets/dist/sitemaps"
			// Base HREF for URLs in sitemaps
			,"basehref" : "http#cgi.server_port_secure?'s':''#://#cgi.server_name#"
			// Max number of URLs to include per sitemap
			,"limit" : 50000
		}
	}

	function onLoad() {
	}
}