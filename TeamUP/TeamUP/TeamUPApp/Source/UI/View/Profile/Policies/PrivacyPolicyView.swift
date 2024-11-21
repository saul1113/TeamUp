//
//  PrivacyPolicyView.swift
//  TeamUP
//
//  Created by Jaemin Hong on 11/17/24.
// 

import SwiftUI

struct PrivacyPolicyView: View {
    private let padding: CGFloat = 20
    private let message: String = """
                                  개인정보처리방침

                                  본 개인정보처리방침은 FOURSIX(이하 "서비스 제공자")가 무료 서비스로 제공하는 모바일 기기용 TeamUp 앱(이하 "애플리케이션")에 적용됩니다. 본 서비스는 "있는 그대로"의 형태로 제공됩니다.


                                  정보 수집 및 이용

                                  애플리케이션은 귀하가 다운로드하고 사용할 때 정보를 수집합니다. 수집되는 정보에는 다음이 포함될 수 있습니다:

                                  - 귀하의 기기의 인터넷 프로토콜 주소(IP 주소 등)
                                  - 귀하의 모바일 기기에 설치된 운영 체제

                                  애플리케이션은 귀하의 모바일 기기의 정확한 위치 정보를 수집하지 않습니다.
                                  

                                  보다 나은 경험을 제공하기 위해 애플리케이션 사용 중 서비스 제공자는 귀하에게 특정 개인 식별 정보를 제공하도록 요청할 수 있습니다. 서비스 제공자가 요청하는 정보는 본 개인정보처리방침에 명시된 대로 보관 및 사용됩니다.


                                  제3자 접근

                                  서비스 제공자는 애플리케이션과 서비스를 개선하기 위해 집계되고 익명화된 데이터를 주기적으로 외부 서비스에 전송할 수 있습니다. 서비스 제공자는 본 개인정보처리방침에 설명된 방식으로 귀하의 정보를 제3자와 공유할 수 있습니다.

                                  서비스 제공자는 사용자 제공 정보 및 자동 수집 정보를 다음과 같이 공개할 수 있습니다:

                                  - 법률에서 요구하는 경우, 예를 들어 소환장이나 유사한 법적 절차를 준수하기 위해.
                                  - 서비스 제공자가 선의로 판단하기에 권리를 보호하고 귀하 또는 타인의 안전을 지키며, 사기를 조사하거나 정부의 요청에 응답하기 위해 공개가 필요하다고 믿는 경우.
                                  - 당사를 대신하여 업무를 수행하며, 당사가 공개한 정보를 독립적으로 사용할 수 없고, 본 개인정보처리방침에 명시된 규칙을 준수하기로 동의한 신뢰할 수 있는 서비스 공급자에게.


                                  옵트아웃 권리

                                  귀하는 애플리케이션을 삭제하여 모든 정보 수집을 손쉽게 중단할 수 있습니다. 이는 귀하의 모바일 기기나 모바일 애플리케이션 마켓플레이스 또는 네트워크에서 제공되는 표준 삭제 절차를 통해 가능합니다.


                                  데이터 보존 정책

                                  서비스 제공자는 귀하가 애플리케이션을 사용하는 동안 및 그 이후 합리적인 기간 동안 사용자 제공 데이터를 보존합니다. 애플리케이션을 통해 제공한 사용자 제공 데이터를 삭제하고자 하는 경우, teamupofficial2024@gmail.com으로 연락해 주시면 합리적인 시간 내에 응답해 드리겠습니다.


                                  아동에 대한 정보

                                  서비스 제공자는 13세 미만의 아동으로부터 고의적으로 데이터를 수집하거나 마케팅을 하지 않습니다.

                                  서비스 제공자는 아동으로부터 고의적으로 개인 식별 정보를 수집하지 않습니다. 서비스 제공자는 모든 아동에게 애플리케이션 및/또는 서비스를 통해 개인 식별 정보를 절대로 제출하지 않도록 권장합니다. 또한 부모 및 법적 보호자에게 자녀의 인터넷 사용을 모니터링하고, 자녀가 허락 없이 애플리케이션 및/또는 서비스를 통해 개인 식별 정보를 제공하지 않도록 지도하여 본 정책을 준수하도록 도와주시기를 권장합니다. 만약 자녀가 애플리케이션 및/또는 서비스를 통해 서비스 제공자에게 개인 식별 정보를 제공했다고 판단되는 경우, 서비스 제공자(teamupofficial2024@gmail.com)에게 연락하여 필요한 조치를 취할 수 있도록 해주시기 바랍니다. 또한 귀하는 귀하의 국가에서 개인 식별 정보 처리에 동의하기 위해 최소한 16세 이상이어야 합니다(일부 국가에서는 부모나 보호자가 귀하를 대신하여 동의할 수 있습니다).


                                  보안

                                  서비스 제공자는 귀하의 정보 기밀성을 보호하는 데 최선을 다하고 있습니다. 서비스 제공자는 처리하고 유지하는 정보를 보호하기 위해 물리적, 전자적, 절차적 보안 조치를 제공합니다.


                                  변경 사항

                                  본 개인정보처리방침은 필요에 따라 수시로 업데이트될 수 있습니다. 서비스 제공자는 본 페이지에 새로운 개인정보처리방침을 게시함으로써 변경 사항을 알려드립니다. 변경 사항이 있는지 정기적으로 본 개인정보처리방침을 확인하시기 바라며, 지속적인 사용은 모든 변경 사항에 대한 승인으로 간주됩니다.

                                  본 개인정보처리방침은 2024년 11월 17일부터 유효합니다.


                                  귀하의 동의

                                  애플리케이션을 사용함으로써 귀하는 본 개인정보처리방침에 명시된 대로 귀하의 정보 처리에 동의하는 것으로 간주됩니다.


                                  문의하기

                                  애플리케이션 사용 중 개인정보와 관련된 질문이나 관행에 대한 문의 사항이 있으시면 서비스 제공자(teamupofficial2024@gmail.com)에게 연락해주시기 바랍니다.
                                  """
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("개인정보처리방침")
                    .font(.bold20)
                
                Divider()
                    .padding(.horizontal, -padding)
                
                Text(message)
                    .font(.semibold18)
            }
            .padding(.horizontal, padding)
            .navigationTitle("개인정보처리방침")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem (placement: .topBarLeading) {
                    BackButtonBlack()
                }
            }
        }
    }

}

#Preview {
    PrivacyPolicyView()
}
