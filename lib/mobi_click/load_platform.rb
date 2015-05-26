require "mobi_click/platforms/appiuml"

module MobiClick
  module LoadPlatform
   @@platform=nil

    def self.load_platform(mobiclick_caps={},caps)
      mobiclick_caps or raise "Mobiclick capabilities must be provided"
      caps or raise "Tool Specific capabilities must be provided"
      Adapter.set(:tool,Capabilities.new(mobiclick_caps).tool)
      set_platform
      register_platform(caps)
    end

    def self.tool
      Adapter.get[:tool]
    end

    def self.set_platform
      begin
        @@platform=Object.const_get("MobiClick::#{tool}")
      rescue
         raise "We don't have implementation for the specified tool -- #{tool} -- ."
      end
    end

   def self.get_platform
     @@platform
   end

    def self.register_platform(caps)
      @@platform.register(caps)
    end

  end
end