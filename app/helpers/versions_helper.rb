module VersionsHelper
  def humanize_version_change(changeset)
    changeset.reject do |k|
      k == 'updated_at'
    end.map do |k, vs|
      case k
      when 'password_digest'
        'changed password'
      when 'deleted_at'
        'archived'
      else
        "#{k} from #{vs[0]} to #{vs[1]}"
      end
    end.to_sentence
  end
end
