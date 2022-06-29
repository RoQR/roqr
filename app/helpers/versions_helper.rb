module VersionsHelper
  def humanize_version_change(changeset)
    changeset.reject do |k|
      k == 'updated_at'
    end.map { |k, vs| k == 'password_digest' ? 'changed password' : "#{k} from #{vs[0]} to #{vs[1]}" }.to_sentence
  end
end
