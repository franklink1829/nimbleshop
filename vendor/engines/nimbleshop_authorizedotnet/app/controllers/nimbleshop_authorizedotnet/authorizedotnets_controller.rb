#TODO add respond_to
module NimbleshopAuthorizedotnet
  class AuthorizedotnetsController < ::Admin::PaymentMethodsController

    before_filter :load_payment_method

   def update
      respond_to do |format|
        if @payment_method.update_attributes(post_params[:authorizedotnet])
          format.js  {
            flash[:notice] = "Authorize.net record was successfully updated"
            render js: "window.location = '/admin/payment_methods'"
          }
        else
          msg =  @payment_method.errors.full_messages.first
          error =  %Q[alert("#{msg}")]
          format.js { render js: error }
        end
      end
    end

    private

    def post_params
        params.permit(authorizedotnet: [:login_id, :transaction_key, :use_ssl, :company_name_on_creditcard_statement])
    end

    def load_payment_method
      @payment_method = NimbleshopAuthorizedotnet::Authorizedotnet.first
    end

  end
end
