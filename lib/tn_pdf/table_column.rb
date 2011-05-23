module TnPDF
  class Table

    class Column
      attr_reader :header, :proc, :collection

      alias_method :to_proc, :proc
      def initialize(arguments, collection=[])
        raise ArgumentError unless valid_column_args?(arguments, collection)
        @header = arguments[0].to_s
        @proc   = arguments[1].to_proc
        @collection = collection
      end

      def values
        @collection.map do |object|
          @proc.call(object)
        end
      end

      def collection=(collection)
        raise ArgumentError unless collection.kind_of? Array
        @collection = collection
      end
      private

      def valid_column_args?(column_args, collection)
        validity  = true
        validity &= column_args.kind_of? Array
        validity &= column_args.count == 2
        validity &= column_args[0].respond_to?(:to_s)
        validity &= column_args[1].respond_to?(:to_proc)
        validity &= collection.kind_of? Array
      rescue NoMethodError
        valid = false
      ensure
        return validity
      end
    end

  end
end