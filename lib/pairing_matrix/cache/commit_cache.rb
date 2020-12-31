require 'date'

module PairingMatrix
  def self.enable_caching=(enabled)
    @cache_enabled = enabled
  end

  def self.cache_enabled
    @cache_enabled
  end

  class CommitCache
    def initialize
      @cache = {}
      @timestamp = Date.today
    end

    def put(date, response)
      @cache[date] = response
    end

    def get(date)
      return nil unless PairingMatrix.cache_enabled

      if Date.today == @timestamp
        @cache[date]
      else
        invalidate_cache
        nil
      end
    end

    private
    def invalidate_cache
      @cache = {}
    end
  end
end