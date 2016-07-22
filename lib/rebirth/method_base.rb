module Rebirth
  class MethoBase < Base

    private

    # TODO: naming
    def __get_value(key)
      @object.__send__(key)
    end
  end
end
