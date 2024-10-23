import  { useState } from 'react';
import axios from 'axios';
import { Input, Card,Typography,Button,Space ,List} from 'antd';

const {Title, Paragraph} = Typography

const Search = () => {
  const [address, setAddress] = useState("");
  const [nftData, setNftData] = useState(null); 
  const [error, setError] = useState(null); 
  const [tokenId, setTokenId] = useState("")

  const fetchNFTData = async () => {
    try {
      let config = {
        method: 'get',
        maxBodyLength: Infinity,
        url: `https://deep-index.moralis.io/api/v2.2/nft/${address}/${tokenId}`,
        headers: {
          'Content-Type': 'application/json',
          'X-API-Key':`${process.env.API_KEY}`,
        },
      };
      const response = await axios.request(config);
      setNftData(response.data);
      setError(null);
    } catch (error) {
      setError(error.message);
      setNftData(null);
    }
  };

  return (
    <>
    <Space
      direction="vertical"
    >
      <Input
        placeholder="Enter NFT Address"
        required
        onChange={(e) => { setAddress(e.target.value); }}
      />
      <Input
        placeholder="Enter ID"
        onChange={(e) => { setTokenId(e.target.value); }}
      />
      <Button onClick={fetchNFTData}>Fetch NFT Data</Button>
    </Space>

      {error && <Paragraph style={{ color: 'red' }}>Error: {error}</Paragraph>}
      {nftData && 
          <List
            dataSource={nftData}
            renderItem={(loan) => 
            <List.Item>
              <Card
                hoverable
                style={{ width: 300 }}
                cover={<img alt="example" src={response?.image}/>}
              >
                <>
                  <Space align="center">
                    <Paragraph strong>Token Address:</Paragraph>
                    <Paragraph>{loan?.token_address}</Paragraph>
                  </Space>
                  <Space align='center'>
                    <Paragraph strong>Token Id</Paragraph>
                    <Paragraph>{loan?.token_id}</Paragraph>
                  </Space>
                  <Space align='center'>
                    <Paragraph strong>Owner:</Paragraph>
                    <Paragraph>{loan?.owner_of}</Paragraph>
                  </Space>
                  <Space align='center'>
                    <Paragraph strong>Floor Price:</Paragraph>
                    <Paragraph>{loan?.floor_price}</Paragraph>
                  </Space>
                  <Space align='center'>
                    <Paragraph strong>Floor Price(USD):</Paragraph>
                    <Paragraph>{loan?.floor_price_usd} ETH</Paragraph>
                  </Space>
                </>
              </Card>
            </List.Item>}
          />
      } 
    </>
  );
};

export default Search;