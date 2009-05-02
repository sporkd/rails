module ActionController
  module Rails2Compatibility
  
    # Temporary hax
    setup do
      cattr_accessor :session_options
      self.send(:class_variable_set, "@@session_options", {})
      
      cattr_accessor :allow_concurrency
      self.send(:class_variable_set, "@@allow_concurrency", false)
      
      cattr_accessor :param_parsers
      self.send(:class_variable_set, "@@param_parsers", { Mime::MULTIPART_FORM   => :multipart_form,
                          Mime::URL_ENCODED_FORM => :url_encoded_form,
                          Mime::XML              => :xml_simple,
                          Mime::JSON             => :json })
                          
      cattr_accessor :relative_url_root
      self.send(:class_variable_set, "@@relative_url_root", ENV['RAILS_RELATIVE_URL_ROOT'])
      
      cattr_accessor :default_charset
      self.send(:class_variable_set, "@@default_charset", "utf-8")
    end
  
    def render_to_body(options)
      if options.is_a?(Hash) && options.key?(:template)
        options[:template].sub!(/^\//, '')
      end
      super
    end
   
   def _layout_for_name(name)
     name &&= name.sub(%r{^/?layouts/}, '')
     super
   end
   
  end
end