component {

	property name="settings" inject="coldbox:setting:sitemaputils";

	array function create(required string prefix, required array urls) {
		var ii = 1;
		var jj = 1;
		var uri;
		var mapsCreated = [];

		loop array="#urls#" item="uri" index="jj" {
			if (isnull(local.map))
				local.map = openSiteMap("#prefix#-#numberformat(ii,'0000')#", mapsCreated);

			addURI(local.map, uri);
			
			if (not jj mod settings.limit) {
				closeSiteMap( local.map );
				ii++;
				local.map = nullValue();
			}
		}

		if (!isnull(local.map))
			closeSiteMap(local.map);
		
		return mapsCreated;
	} 

	private any function openSiteMap(required string fileName, required array mapsCreated) {
		var path = "#settings.dist#/#filename#.xml";
		var result = fileopen(expandpath(path), "write", "utf-8");
		filewriteline(result, '<?xml version="1.0" encoding="UTF-8"?>');
		filewriteline(result, '<urlset xmlns="http://www.google.com/schemas/sitemap/0.84">');
		
		mapsCreated.append(path);

		return result;
	}

	private void function closeSiteMap(required any sitemap) {
		filewriteline(arguments.sitemap, '</urlset>');
		fileClose(arguments.sitemap);
	}

	private void function addURI(required any sitemap, required any URI) {
		var item = arguments.URI;
		if (isSimpleValue(arguments.URI))
			item = { loc:arguments.URI }

		filewriteline(arguments.sitemap, '	<url>');
		filewriteline(arguments.sitemap, '		<loc>#settings.basehref##item.loc#</loc>');
		if (!isnull(item.changefreq))
			filewriteline(arguments.sitemap, '		<changefreq>#item.changefreq#</changefreq>');
		if (!isnull(item.priority))
			filewriteline(arguments.sitemap, '		<priority>#item.priority#</priority>');
		if (!isnull(item.lastmod))
			filewriteline(arguments.sitemap, '		<lastmod>#dateformat(item.lastmod,"yyyy-mm-dd")#</lastmod>');
		filewriteline(arguments.sitemap, '	</url>');
	}

}