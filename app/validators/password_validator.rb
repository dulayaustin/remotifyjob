class PasswordValidator < ActiveModel::Validator
  def validate(record)
    if record.password != record.confirm_password
      record.errors.add :password, "does not match"
    end
  end
end
