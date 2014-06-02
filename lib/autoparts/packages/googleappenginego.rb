module Autoparts
  module Packages
    class GoogleAppEngineGo < Package
      name 'googleappenginego'
      version '1.9.5'
      description 'Google App Engine for Go: A CLI for managing Google App Engine cloud services for Go'
      category Category::DEPLOYMENT

      source_url 'https://storage.googleapis.com/appengine-sdks/featured/go_appengine_sdk_linux_amd64-1.9.5.zip'
      source_sha1 'cba2407efffd9540d5f3c56460f6958bd5647f68'
      source_filetype 'zip'

      def install
        prefix_path.parent.mkpath
        FileUtils.rm_rf prefix_path
        execute 'mv', extracted_archive_path + 'go_appengine', prefix_path
      end

      def post_install
        bin_path.mkpath
        Dir[prefix_path + "*.py"].each do |p|
          basename = File.basename(p)
          execute 'ln', '-fs', prefix_path + basename, bin_path + basename
        end
        ["goapp", "gofmt", "godoc"].each do |p|
          execute 'ln', '-fs', prefix_path + p, bin_path + p
        end
      end
    end
  end
end
