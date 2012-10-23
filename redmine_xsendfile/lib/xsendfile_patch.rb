module XsendfilePatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      alias_method_chain :send_file, :xsendfile
    end
  end

  module InstanceMethods
    def send_file_with_xsendfile(path, options = {})
      if params[:controller] == 'attachments'
        case Setting.plugin_redmine_xsendfile['mode']
        when 'nginx'
          options[:length]   ||= File.size(path)
          options[:filename] ||= File.basename(path) unless options[:url_based_filename]
          send_file_headers! options
          @performed_render = false
          xsendfile_path = path.gsub(/^#{Regexp.quote(Attachment.storage_path)}/, '/xsendfile')
          logger.info "Sending X-Accel-Redirect header #{xsendfile_path}" if logger
          head options[:status], 'X-Accel-Redirect' => xsendfile_path
        else
          send_file_without_xsendfile(path, options)
        end
      else
        send_file_without_xsendfile(path, options)
      end
    end
  end
end
