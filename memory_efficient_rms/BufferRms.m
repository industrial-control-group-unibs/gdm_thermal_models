classdef BufferRms < handle
    properties
        slow_buffer;
        medium_buffer;
        fast_buffer;
        size
    end

    methods
        function obj=BufferRms(fast_buffer_size, medium_buffer_size, slow_buffer_size)
            obj.slow_buffer=SumBuffer(slow_buffer_size);
            obj.medium_buffer=SumBuffer(medium_buffer_size);
            obj.fast_buffer=SumBuffer(fast_buffer_size);
            obj.size=slow_buffer_size*medium_buffer_size*fast_buffer_size;
        end

        function overflow=pushNewData(obj,new_data)
            overflow=obj.fast_buffer.pushNewData(new_data^2);
            if overflow
                overflow=obj.medium_buffer.pushNewData(obj.fast_buffer.getSum());
                if overflow
                    overflow=obj.slow_buffer.pushNewData(obj.medium_buffer.getSum());
                end
            end
        end
        
        function rms_value=rms(obj)
            rms_value=sqrt(obj.slow_buffer.getSum()/obj.size);
        end
    end
end