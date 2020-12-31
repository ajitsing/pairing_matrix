require './lib/pairing_matrix/config/config'
require './lib/pairing_matrix/config/config_reader'

describe PairingMatrix::ConfigReader do
    describe '#config' do
      context '#global config' do
        it 'should have author regex' do
          config_reader = PairingMatrix::ConfigReader.new('./spec/lib/pairing_matrix/config/sample_configurations/local_repositories.yml')
          configuration = config_reader.config

          expect(configuration.authors_regex).to eql('^.*\[([\w]*)(?:\/)?([\w]*)\].*$')
        end
      end

      context 'when local repositories are present' do
        it 'read local repositories' do
            config_reader = PairingMatrix::ConfigReader.new('./spec/lib/pairing_matrix/config/sample_configurations/local_repositories.yml')
            configuration = config_reader.config

            expect(configuration.local_repositories.repositories.size).to eql(3)
            expect(configuration.local_repositories.repositories).to eql([
                '/Users/Ajit/projects/project1',
                '/Users/Ajit/projects/project2',
                '/Users/Ajit/projects/project3'
                ])
        end
      end

      context 'when github public repositories are present' do
        it 'should read github public repositories' do
            config_reader = PairingMatrix::ConfigReader.new('./spec/lib/pairing_matrix/config/sample_configurations/github_public_repositories.yml')
            configuration = config_reader.config

            expect(configuration.github_public_repositories.repositories.size).to eql(2)
            expect(configuration.github_public_repositories.repositories).to eql(['org1/repo1', 'org1/repo2'])
        end
      end

      context 'when github private repositories are present' do
        it 'should read github private repositories' do
            config_reader = PairingMatrix::ConfigReader.new('./spec/lib/pairing_matrix/config/sample_configurations/github_private_repositories.yml')
            configuration = config_reader.config

            expect(configuration.github_private_repositories.repositories.size).to eql(2)
            expect(configuration.github_private_repositories.repositories).to eql(['github_username/my_private_repo_1', 'github_username/my_private_repo_2'])
            expect(configuration.github_private_repositories.access_token).to eql('000324cff69wes5613f732c345hn679c0knt509c')
            expect(configuration.github_private_repositories.url).to eq('https://api.github.com/')
        end
      end

      context 'when github enterprise repositories are present' do
        it 'should read github enterprise repositories' do
            config_reader = PairingMatrix::ConfigReader.new('./spec/lib/pairing_matrix/config/sample_configurations/github_enterprise_repositories.yml')
            configuration = config_reader.config

            expect(configuration.github_enterprise_repositories.repositories.size).to eql(2)
            expect(configuration.github_enterprise_repositories.repositories).to eql(['github_username/repo_1', 'github_username/repo_2'])
            expect(configuration.github_enterprise_repositories.access_token).to eql('000324cff69wes5613f732c345hn679c0knt509d')
            expect(configuration.github_enterprise_repositories.url).to eql('http://git.mycompany.com/api/v3/')
        end
      end

      context 'when gitlab repositories are present' do
        it 'should read gitlab repositories' do
            config_reader = PairingMatrix::ConfigReader.new('./spec/lib/pairing_matrix/config/sample_configurations/gitlab_repositories.yml')
            configuration = config_reader.config

            expect(configuration.gitlab.repositories.size).to eql(2)
            expect(configuration.gitlab.repositories).to eql(['gitlab_username/my_repo_1', 'gitlab_username/my_repo_2'])
            expect(configuration.gitlab.access_token).to eql('Eu2ZVk8lL3P0YGw_aCFl')
            expect(configuration.gitlab.url).to eql('https://gitlab.com/api/v4')
        end
      end
    end
end