class PersonsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_person, only: %i[show edit update destroy]

  def index
    @persons = Person.all.sorted
  end

  def show
    @person = Person.find(params[:id])
  end

  def new
    @person = Person.new
    @person.educations.build
    @person.certificates.build
    @person.professional_experiences.build
    @person.skills.build
  end

  def create
    @person = Person.new(person_params)

    if @person.save
      redirect_to @person, notice: 'Successfully created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @person.update(person_params)
      redirect_to @person, notice: 'Successfully updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @person.destroy
    redirect_to root_path, notice: 'Successfully deleted'
  end

  private

  def person_params
    params.require(:person).permit(
      :name, :email, :phone, :role, :summary,
      educations_attributes: %i[id institution_name degree field_of_study started_on ended_on _destroy],
      certificates_attributes: %i[id issuing_organization name issued_on _destroy],
      professional_experiences_attributes: %i[id company_name role description started_on ended_on _destroy],
      skills_attributes: %i[id name proficiency_level _destroy]
    )
  end

  def set_person
    @person = Person.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to persons_path, alert: 'Not found'
  end
end
