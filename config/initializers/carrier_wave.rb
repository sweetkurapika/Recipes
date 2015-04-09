if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials ={
      :provider => 'AWS',
      :aws_access_key_id => ENV['S3_ACCESS_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET_KEY']
    }

    config.fog_directory = ENV['S3_BUCKET']
  end
end


=begin
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::shibaburailsrecipes",
        "arn:aws:s3:::shibaburailsrecipes/*"
      ]
    },

    {
      "Effect": "Allow",
      "Action": "s3:ListAllMyBuckets",
      "Resource": "arn:aws:s3:::*"
    }
  ]
}
=end
