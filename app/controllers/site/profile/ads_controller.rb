class Site::Profile::AdsController < Site::ProfileController
  before_action :set_ad, only: [:edit, :update]

  def index
    @ads = Ad.of_the(current_member)
  end

  def new
    @ad = Ad.new
  end

  def create
    @ad = Ad.new(params_ad)
    @ad.member = current_member
    if @ad.save
      redirect_to site_profile_ads_path, notice: I18n.t('messages.created')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @ad.update(params_ad)
      redirect_to site_profile_ads_path, notice: I18n.t('messages.updated')
    else
      render :edit
    end
  end

  private

  def set_ad
    @ad = Ad.find(params[:id])
  end

  def params_ad
    params.require(:ad).permit( :id, :title, :category_id, :price,
                                :description, :picture, :finish_date,
                                :description_md, :description_short)
  end
end
