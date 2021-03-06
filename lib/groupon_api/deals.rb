module GrouponApi
  def self.deals(params)
    raise ::ArgumentError, 'param :ts_token cannot be nil' if GrouponApi.config.ts_token.nil?
    raise ::ArgumentError, 'param :ts_token must match /UK_AFF_0_\d+_\d+_0/' unless GrouponApi.config.ts_token.match(API_KEY_FORMAT)
    
    params.merge!(tsToken: GrouponApi.config.ts_token)
    params.merge!(GrouponApi.config.deals) if GrouponApi.config.deals.kind_of?(Hash)
    
    puts "#{__FILE__}:#{__LINE__} params: #{params}" if GrouponApi.config.debug

    results = GrouponApi::Request.call('deals', params)
    
    return [] if results.nil? || results.length == 0 || results['deals'].nil?

    results['deals'].collect{|deal| HashWithIndifferentAccess.new(deal)}
  end
end
