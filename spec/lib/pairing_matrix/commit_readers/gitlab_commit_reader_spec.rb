require 'ostruct'
require './lib/pairing_matrix/commit_readers/gitlab_commit_reader'

describe PairingMatrix::GitlabCommitReader do
    context '#authors_with_commits' do
        it 'returns authors with number of commits' do
            config_reader = PairingMatrix::ConfigReader.new('./spec/lib/pairing_matrix/config/sample_configurations/gitlab_repositories.yml')
            configuration = config_reader.config
            gitlab_config = configuration.gitlab

            days = 10
            reader = PairingMatrix::GitlabCommitReader.new(gitlab_config)

            gitlab_client = double(:gitlab_client)
            expect(Gitlab).to receive(:client)
                .with(private_token: gitlab_config.access_token, endpoint: gitlab_config.url)
                .and_return(gitlab_client)

            commits = [
                OpenStruct.new(title: "[Author1/Author2] commit 1"),
                OpenStruct.new(title: "[Author1/Author2] commit 2"),
                OpenStruct.new(title: "[Author2/Author3] commit 3"),
                OpenStruct.new(title: "[Author2/Author3] commit 4"),
                OpenStruct.new(title: "[Author4/Author1] commit 5"),
            ]

            expect(gitlab_client).to receive(:commits)
                .with(gitlab_config.repositories.first, since: (Date.today - days).to_s)
                .and_return(commits)

            expect(gitlab_client).to receive(:commits)
                .with(gitlab_config.repositories.last, since: (Date.today - days).to_s)
                .and_return(commits)

            result = reader.authors_with_commits(10)

            expect(result).to eql([["Author1", "Author2", 4], ["Author2", "Author3", 4], ["Author1", "Author4", 2]])
        end
    end
end