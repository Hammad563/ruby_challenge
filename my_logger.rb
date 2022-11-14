class MyLogger
    attr_reader :data, :info_size, :warn_size, :error_size
    attr_accessor :info_buffer, :warn_buffer, :error_buffer
    def initialize(data=nil)
        @data = data
        @info_buffer,@warn_buffer,@error_buffer = [], [], []
        @info_size = data[:info_size] if data != nil
        @warn_size = data[:warn_size] if data != nil
        @error_size = data[:error_size] if data != nil
    end

    def info(value, tag='')
        if data && info_size
            buffer_load(buffertype: info_buffer, buffersize: info_size, value: '[INFO] ' + value)
        else
            display_log('[INFO] ' + value, tag)
        end
    end
    def warn(value, tag='')
        if data && warn_size
            buffer_load(buffertype: @warn_buffer, buffersize: warn_size, value: '[WARN] ' + value)
        else
            display_log('[WARN] ' + value, tag)
        end
    end

    def error(value, tag='')
        if data && error_size
            buffer_load(buffertype: error_buffer, buffersize: error_size, value: '[ERROR] ' + value)
        else
            display_log('[ERROR] ' + value, tag)
        end
    end

    def buffer_load(buffertype:, buffersize:, value:)
        buffertype << value
        if buffertype.length == buffersize
            return buffertype
        elsif buffertype.length > buffersize
             buffertype.clear
             buffertype << value
            return nil
        else
            return nil
        end
    end
    def display_log(output, tag)
        if tag && tag.length > 0
            return "[#{tag}]" + output
        else
            return output
        end
    end
end



