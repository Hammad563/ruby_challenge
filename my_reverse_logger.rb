class MyReverseLogger < MyLogger
    # Supports buffering and tagging through inheritance (Tests have been written)
    def info(value,tag='')
        if data && info_size
            buffer_load(buffertype: info_buffer, buffersize: info_size, value: '[INFO] ' + value.reverse)
        else
            display_log('[INFO] ' + value.reverse, tag)
        end
    end
    def warn(value,tag='')
        if data && warn_size
            buffer_load(buffertype: @warn_buffer, buffersize: warn_size, value: '[WARN] ' + value.reverse)
        else
            display_log('[WARN] ' + value.reverse, tag)
        end
    end

    def error(value,tag='')
        if data && error_size
            buffer_load(buffertype: error_buffer, buffersize: error_size, value: '[ERROR] ' + value.reverse)
        else
            display_log('[ERROR] ' + value.reverse, tag)
        end
    end
end