import { LightningElement } from 'lwc';

export default class TestCallout extends LightningElement {
    async connectedCallback() {

        const apiUrl = 'https://api.linkedin.com/v2/ugcPosts';

        const payload = {
            author: 'urn:li:person:TYR0aqmL_k',
            lifecycleState: 'PUBLISHED',
            specificContent: {
                'com.linkedin.ugc.ShareContent': {
                    shareCommentary: {
                        text: 'Hello World! This is my first Share on LinkedIn!'
                    },
                    shareMediaCategory: 'NONE'
                }
            },
            visibility: {
                'com.linkedin.ugc.MemberNetworkVisibility': 'PUBLIC'
            }
        };

        try {
            const response = await fetch(apiUrl, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer AQWescod6hJO37WB6vEbjEmifO0nL3JTfJNzARLCDyawYeye7l4iA5L1gG947ZbmEIB-wOld9WNUPFU5xlbWy7-EIBivQ-4rKhj1pVur5TWk7F6Ifp9ZGMQK1RQjEJt4iXVzbVCeCKmHIaq1O46mvsvkrs8uXFahEyZ0sFshlwdugfwjDNfcVnJ_DA1UQA2gqkN69f0nnSMghiRo077sbhPvrZGrUfeoVajC1F7D7OXpMrQzO_5pWxiNHNCbXpdGZZ8L8KPAs5hy4Hu5hJs9nKjz5Q6VqRRzTLx2eG1tBrjseVutUmiBgypuexhP-2z_L4vloOIlPoleQTjdHYlSKVYYMqAvASWGsiBusTs97WIfAklSR0cwriQE2pegofMVp8aWH95DW3_UbR8wVDI',
                    'Access-Control-Allow-Origin' : 'https://connect-innovation-1672-dev-ed.scratch.lightning.force.com'
                 },
                body: JSON.stringify(payload)
            });
            console.log('response ', response);
            if (response.ok) {
                const data = await response.json();
                console.log('API Response:', data);
            } else {
                console.error('API Request failed:', response.statusText);
            }
        } catch (error) {
            console.error('API Request Error:', error);
        }
    }

}