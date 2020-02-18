component {

	property name="settings" inject="coldbox:modulesettings:sitemaputils";

	string function create(required string fileName, required array sitemapURLs, any urlFilterClosure) {
		directoryCreate(expandpath(settings.dist), true, true);

		var path = "#settings.dist#/#filename#.xml";
		var myIndex = fileopen(expandpath(path), "write", "utf-8");
		filewriteline(myIndex, '<?xml version="1.0" encoding="UTF-8"?>');
		filewriteline(myIndex, '<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">');

		if (isnull(arguments.urlFilterClosure)) {
			arguments.urlFilterClosure = function(original) { return original; };
		}

		loop array="#arguments.sitemapURLs#" item="uri" {
			filewriteline(myIndex, '	<sitemap>');
			filewriteline(myIndex, '		<loc>#settings.basehref##urlFilterClosure(uri)#</loc>');
			filewriteline(myIndex, '		<lastmod>#dateformat(now(),"yyyy-mm-dd")#</lastmod>');
			filewriteline(myIndex, '	</sitemap>');
		}
		filewriteline(myIndex, '</sitemapindex>');
		fileclose(myIndex);
		return path;
	}

}