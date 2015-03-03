module Pushable
  class Stub
    attr_reader :klass, :fields

    def initialize(klass, fields = {})
      @klass = klass
      @fields = fields
      validate
    end

    private

      def validate
        fields.each do |k, v|
          raise ArgumentError.new("Field types must be in: [:string, :integer]") if ![:string, :integer].include?(v)
        end
      end

  end
end
