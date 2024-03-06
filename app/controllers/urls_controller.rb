class UrlsController < ApplicationController

  before_action :require_login

  def index
    @url = Url.new
    @short_link = params[:short_link]
    @original_url = params[:original_url]
    @short_url = params[:short_url]
  end

  def create
    @url = current_user.urls.build(url_params)

    if @url.save
      @original_url = @url.original_url
      @short_link = @url.short_link
      @short_url = @url.short_url
      LinkStatisticsJob.set(wait: 3.minutes).perform_later(current_user.id) if current_user.urls.count == 1
      redirect_to root_path(short_link: @url.short_link, original_url: @url.original_url, short_url: @url.short_url), notice: 'URL was successfully created.'
    else
      render :index, status: :unprocessable_entity
    end
  end


  def show
    @urls = current_user.urls
  end

  def destroy
    @url = Url.find_by(id: params[:id])
    @url.destroy
    redirect_to show_urls_path, notice: 'Link was successfully deleted.'
  end

  def redirect
    @url = Url.find_by(short_url: params[:short_url])
    if @url
      @url.update_attribute(:click, @url.click.to_i + 1)
      redirect_to @url.original_url, allow_other_host: true
    else
      redirect_to root_path, status: 404
    end
  end

  def delete_all
    current_user.urls.destroy_all
    redirect_to show_urls_path, notice: 'Links deleted successfully'
  end


  # Strong parameters to filter params and specify params that are allowed
  private
  def url_params
    params.require(:url).permit(:original_url, :short_url, :user_id)
  end

end
