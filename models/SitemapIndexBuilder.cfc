component {

	property name="settings" inject="coldbox:setting:sitemaputils";

	string function create(required string fileName, required array sitemapURLs, any urlFilterClosure) {
		var path = "#settings.dist#/#filename#.xml";
		var myIndex = fileopen(expandpath(path), "write", "utf-8");
		filewriteline(myIndex, '<?xml version="1.0" encoding="UTF-8"?>');
		filewriteline(myIndex, '<sitemapindex xmlns="http://www.google.com/schemas/sitemap/0.84">');

		if (isnull(arguments.urlFilterClosure)) {
			arguments.urlFilterClosure = function(original) { return original; };
		}

		loop array="#arguments.sitemapURLs#" item="uri" {
			filewriteline(myIndex, '	<sitemap>');
			filewriteline(myIndex, '		<loc>#settings.basehref##urlFilterClosure(uri)#</loc>');
			filewriteline(myIndex, '	</sitemap>');
		}
		filewriteline(myIndex, '</sitemapindex>');
		fileclose(myIndex);
		return path;
	}

}