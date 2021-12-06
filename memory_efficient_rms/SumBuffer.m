classdef SumBuffer < handle
    properties
        buffer
        buffer_idx
        size
        sum=0;
    end
    methods
        function obj=SumBuffer(buffer_size)
            assert(buffer_size>0)
            obj.size=buffer_size;
            obj.buffer=zeros(obj.size,1);
            obj.sum=0;
            obj.buffer_idx=1;
        end
        function overflow=pushNewData(obj,new_data)
            obj.sum=obj.sum-obj.buffer(obj.buffer_idx);
            obj.buffer(obj.buffer_idx)=new_data;
            obj.sum=obj.sum+obj.buffer(obj.buffer_idx);
            
            if (obj.buffer_idx>=obj.size)
                obj.buffer_idx=1;
                overflow=1;
            else
                obj.buffer_idx=obj.buffer_idx+1;
                overflow=0;
            end
        end

        function sum_of_square=getSum(obj)
            sum_of_square=obj.sum;
        end
    end
end