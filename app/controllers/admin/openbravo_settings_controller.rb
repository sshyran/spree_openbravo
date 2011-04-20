class Admin::OpenbravoSettingsController < Admin::BaseController

  def edit
    @organizations = Rails.cache.fetch('openbravo-organizations-list') do
      Openbravo::Organization.all.map{|org| [org.identifier, org.id].flatten.uniq }
    end
    
    @tax_categories = Rails.cache.fetch('openbravo-tax-categories') do
      Openbravo::TaxCategory.all.map{|cat| [cat.name, cat.id].flatten.uniq }
    end
    
    @price_lists = Rails.cache.fetch('openbravo-price-lists') do
      Openbravo::PriceList.all.map{|list| [list.name, list.id].flatten.uniq }
    end
  end

  def update
    Spree::Openbravo::Config.set(params[:preferences])
    
    respond_to do |format|
      format.html {
        redirect_to admin_openbravo_settings_path
      }
    end
  end

end
