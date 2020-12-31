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
            expect(configuration.github_private_repositories.url).to be_nil
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
    end
end