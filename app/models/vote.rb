class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: true
  belongs_to :user

  validate :validate_votable_type

  validates :user_id,
    uniqueness: {
      scope: [:votable_id, :votable_type],
      message: "can only vote once per item"
    }

  private

  def validate_votable_type
    unless allowed_votable_types.include?(votable_type)
      errors.add(:votable_type, "is not a valid votable type")
    end
  end

  def allowed_votable_types
    # Ensure all models are loaded in development mode
    Rails.application.eager_load! if Rails.env.development?

    # Find all classes that include the Votable module
    votable_classes = ObjectSpace.each_object(Class).select { |klass| klass.included_modules.include?(Votable) }
    votable_classes.map(&:name)
  end
end
