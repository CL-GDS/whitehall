class Admin::RolesController < Admin::BaseController
  before_action :load_role, only: %i[edit update destroy]
  layout :get_layout

  def index
    @roles = Role.includes(:role_appointments, :current_people, :translations, organisations: [:translations])
                  .order("organisation_translations.name, roles.type DESC, roles.permanent_secretary DESC, role_translations.name")

    render_design_system("index", "legacy_index")
  end

  def new
    @role = Role.new

    render_design_system("new", "legacy_new")
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to index_or_edit_path, notice: %("#{@role.name}" created.)
    else
      render_design_system("new", "legacy_new")
    end
  end

  def edit
    @role = Role.find(params[:id])

    render_design_system("edit", "legacy_edit")
  end

  def update
    if @role.update(role_params)
      redirect_to index_or_edit_path, notice: %("#{@role.name}" updated.)
    else
      render_design_system("edit", "legacy_edit")
    end
  end

  def confirm_destroy
    @role = Role.find(params[:id])
  end

  def destroy
    notice = %("#{@role.name}" destroyed.)
    if @role.destroy
      redirect_to(admin_roles_path, notice:)
    else
      message = "Cannot destroy a role with appointments, organisations, or documents"
      redirect_to admin_roles_path, alert: message
    end
  end

private

  def index_or_edit_path
    if params[:save_and_continue].present?
      edit_admin_role_path(@role)
    else
      admin_roles_path
    end
  end

  def load_role
    @role = Role.find(params[:id])
  end

  def role_params
    params.require(:role).permit(
      :name,
      :role_type,
      :whip_organisation_id,
      :role_payment_type_id,
      :attends_cabinet_type_id,
      :responsibilities,
      organisation_ids: [],
      worldwide_organisation_ids: [],
    ).merge(type: sti_type)
  end

  def sti_type
    RoleTypePresenter.role_attributes_from(params[:role][:role_type])[:type]
  end

  def get_layout
    design_system_actions = []
    design_system_actions += %w[index confirm_destroy edit update new create] if preview_design_system?(next_release: false)

    if design_system_actions.include?(action_name)
      "design_system"
    else
      "admin"
    end
  end
end
