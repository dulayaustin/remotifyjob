class ResumeValidator < ActiveModel::Validator
  def validate(record)
    return record.errors.add :resume, "no file added" unless record.resume.attached?
    record.errors.add :resume, "accepts pdf file type only" unless [ "application/pdf" ].include?(record.resume.content_type)
  end
end
