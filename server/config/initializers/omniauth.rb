OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, '621483531320934', '7ebc114be53a7e634596c3719e850c08'
end
