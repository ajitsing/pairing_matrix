require 'ostruct'
require './lib/pairing_matrix/commit_readers/github_commit_reader'

describe PairingMatrix::GithubCommitReader do
    context '#authors_with_commits' do
        it 'returns authors with number of commits' do
            config_reader = PairingMatrix::ConfigReader.new('./spec/lib/pairing_matrix/config/sample_configurations/github_repositories.yml')
            configuration = config_reader.config
            github_config = configuration.github

            days = 10
            reader = PairingMatrix::GithubCommitReader.new(github_config)

            github_client = double(:github_client)
            expect(Octokit::Client).to receive(:new)
                .with(access_token: github_config.access_token)
                .and_return(github_client)

            commits = [
                OpenStruct.new(commit: OpenStruct.new(message: "[Author1/Author2] commit 1")),
                OpenStruct.new(commit: OpenStruct.new(message: "[Author1/Author2] commit 2")),
                OpenStruct.new(commit: OpenStruct.new(message: "[Author2/Author3] commit 3")),
                OpenStruct.new(commit: OpenStruct.new(message: "[Author2/Author3] commit 4")),
                OpenStruct.new(commit: OpenStruct.new(message: "[Author4/Author1] commit 5")),
            ]

            expect(github_client).to receive(:commits_since)
                .with(github_config.repositories.first, (Date.today - days).to_s)
                .and_return(commits)

            expect(github_client).to receive(:commits_since)
                .with(github_config.repositories.last, (Date.today - days).to_s)
                .and_return(commits)

            result = reader.authors_with_commits(10)

            expect(result).to eql([["Author1", "Author2", 4], ["Author2", "Author3", 4], ["Author1", "Author4", 2]])
        end
    end
end